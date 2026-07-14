from sentence_transformers import SentenceTransformer
import faiss
import numpy as np
from datetime import datetime

# FOOD DELIVERY POLICY (500+ WORDS)

policy_text = """
Food Delivery Platform Policy

Refund Policy:
Customers may request a refund if their order is cancelled by the restaurant,
if the order contains missing items, damaged items, or if the wrong items are delivered.
Refund requests should be submitted within 24 hours of delivery.
Full refunds may be issued when the restaurant is unable to fulfill the order.
Partial refunds may be granted for missing items or quality-related concerns.

If a delivery is significantly delayed beyond the estimated delivery time,
customers may qualify for compensation depending on the circumstances.
Refund approval is subject to review by the support team.
Approved refunds are generally processed within 5 to 7 business days.

Cancellation Policy:
Customers may cancel an order before the restaurant begins preparation.
Once food preparation has started, cancellation may not be possible.
If the restaurant cancels an order, the customer will automatically receive a full refund.

Repeated misuse of cancellation requests may result in account review.
Special promotional orders may be subject to different cancellation rules.

Delivery Rules:
Customers must provide a correct delivery address and contact information.
If an incorrect address is supplied, delivery delays or failed deliveries may occur.

Drivers will attempt to contact the customer if they cannot locate the address.
If the customer is unavailable after multiple contact attempts,
the order may be marked as undeliverable.

Food quality concerns should be reported within 24 hours.
Photographic evidence may be requested for damaged orders.

The platform strives to deliver orders within the estimated delivery window,
but factors such as traffic, weather, and restaurant workload may affect delivery times.

Late deliveries caused by extreme weather, road closures,
or force majeure events may not qualify for compensation.

The support team reviews all claims fairly and may request additional information.
Customers are encouraged to keep receipts and order confirmations.

Repeated fraudulent refund claims may lead to account suspension.
Abusive behavior toward delivery personnel is strictly prohibited.

The platform reserves the right to modify policies at any time.
Users should review the latest version of the policy periodically.

Refunds for duplicate payments will be processed after verification.
If a payment issue occurs because of a banking error,
customers should contact both the platform and their bank.

Subscription members may receive priority support services.
Premium support benefits do not guarantee refund approval.

Customers should ensure that delivery instructions are clear and accurate.
Restaurants are responsible for preparing orders according to menu descriptions.

In cases where a menu item becomes unavailable after ordering,
the restaurant may substitute an equivalent item or cancel the order.

Support tickets are generally answered within 24 to 48 hours.
The company aims to provide a fair and transparent resolution process for all users.
"""



def create_chunks(text, chunk_size=250):
    sentences = text.split(". ")
    chunks = []
    current = ""

    for sentence in sentences:
        if len(current) + len(sentence) < chunk_size:
            current += sentence + ". "
        else:
            chunks.append(current.strip())
            current = sentence + ". "

    if current:
        chunks.append(current.strip())

    return chunks


chunks = create_chunks(policy_text)


print("Loading embedding model...")

model = SentenceTransformer("all-MiniLM-L6-v2")

embeddings = model.encode(chunks)

dimension = embeddings.shape[1]

index = faiss.IndexFlatL2(dimension)

index.add(np.array(embeddings).astype("float32"))

print(f"Loaded {len(chunks)} policy chunks.")
print("FAISS index ready.\n")


complaint_examples = [
    ("My food arrived 2 hours late.", "Late Delivery"),
    ("I received the wrong order.", "Wrong Item"),
    ("The food package was damaged.", "Damaged Order"),
    ("I was charged twice for one order.", "Payment Issue")
]

example_texts = [x[0] for x in complaint_examples]

example_embeddings = model.encode(example_texts)


LOG_FILE = "session_log.txt"

policy_count = 0
complaint_count = 0

def write_log(mode, query, output):
    with open(LOG_FILE, "a", encoding="utf-8") as f:
        f.write("\n" + "=" * 70 + "\n")
        f.write(f"Timestamp: {datetime.now()}\n")
        f.write(f"Mode: {mode}\n")
        f.write(f"Query: {query}\n")
        f.write(f"Output: {output}\n")




def ask_policy_question():
    global policy_count

    while True:
        question = input("\nEnter policy question: ").strip()

        if question:
            break

        print("Question cannot be empty. Please try again.")

    query_embedding = model.encode([question])

    k = min(3, len(chunks))

    distances, indices = index.search(
        np.array(query_embedding).astype("float32"),
        k
    )

    retrieved_chunks = [chunks[i] for i in indices[0]]

    context = "\n\n".join(retrieved_chunks)

    rag_prompt = f"""
SYSTEM:
You are a food delivery policy assistant.

Answer ONLY using the provided context.

CONTEXT:
{context}

QUESTION:
{question}

ANSWER:
"""

    print("\n" + "=" * 60)
    print("TOP 3 RETRIEVED CHUNKS")
    print("=" * 60)

    for i, chunk in enumerate(retrieved_chunks, 1):
        print(f"\nChunk {i}:\n{chunk}")

    print("\n" + "=" * 60)
    print("RAG PROMPT")
    print("=" * 60)
    print(rag_prompt)

    answer = "Simulated Answer: Retrieved policy information displayed above."

    print("\nAnswer:")
    print(answer)

    policy_count += 1

    write_log("RAG", question, answer)



def classify_complaint():
    global complaint_count

    while True:
        complaint = input("\nEnter complaint: ").strip()

        if complaint:
            break

        print("Complaint cannot be empty. Please try again.")

    prompt = """
Classify the complaint into one category.

Examples:

Complaint: My food arrived 2 hours late.
Category: Late Delivery

Complaint: I received the wrong order.
Category: Wrong Item

Complaint: The food package was damaged.
Category: Damaged Order

Complaint: I was charged twice for one order.
Category: Payment Issue

Complaint: {}
Category:
""".format(complaint)

    complaint_embedding = model.encode([complaint])

    similarities = np.dot(
        example_embeddings,
        complaint_embedding.T
    ).flatten()

    best_idx = np.argmax(similarities)

    best_example = complaint_examples[best_idx]

    predicted_category = best_example[1]

    print("\n" + "=" * 60)
    print("FEW-SHOT PROMPT")
    print("=" * 60)
    print(prompt)

    print("\nPredicted Category:", predicted_category)
    print("Closest Example:", best_example[0])

    complaint_count += 1

    write_log(
        "Classify",
        complaint,
        f"{predicted_category} | Closest Example: {best_example[0]}"
    )



while True:

    print("\n" + "=" * 60)
    print("FOOD DELIVERY HELP DESK CHATBOT")
    print("=" * 60)

    print("1. Ask Policy Question (RAG)")
    print("2. Classify Complaint")
    print("3. Exit")

    choice = input("\nSelect option: ").strip()

    if choice == "1":
        ask_policy_question()

    elif choice == "2":
        classify_complaint()

    elif choice == "3":

        print("\nSession Summary")
        print("-" * 40)
        print(f"Policy Questions Asked : {policy_count}")
        print(f"Complaints Classified  : {complaint_count}")
        print("Session log saved to session_log.txt")
        print("Goodbye!")

        break

    else:
        print("Invalid option. Please choose 1, 2, or 3.")