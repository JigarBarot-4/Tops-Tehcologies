from langchain_ollama import ChatOllama
from langchain_core.chat_history import InMemoryChatMessageHistory
from langchain_core.prompts import ChatPromptTemplate, MessagesPlaceholder
from langchain_core.runnables.history import RunnableWithMessageHistory

# Load Ollama model
llm = ChatOllama(model="mistral")

# Store conversation
store = {}

def get_history(session_id):
    if session_id not in store:
        store[session_id] = InMemoryChatMessageHistory()
    return store[session_id]

# Prompt
prompt = ChatPromptTemplate.from_messages([
    (
        "system",
        """You are a helpful assistant for QuickBite Food Delivery.

Remember the customer's delivery address and dietary preference once they tell you.
Use that information in future replies without asking again.
"""
    ),
    MessagesPlaceholder(variable_name="history"),
    ("human", "{input}")
])

# Create chatbot
chain = prompt | llm

chatbot = RunnableWithMessageHistory(
    chain,
    get_history,
    input_messages_key="input",
    history_messages_key="history",
)

print("QuickBite Food Assistant")
print("Type 'exit' to stop.\n")

turns = 0
session_id = "user1"

while True:

    user = input("User: ")

    if user.lower() == "exit":
        break

    response = chatbot.invoke(
        {"input": user},
        config={"configurable": {"session_id": session_id}}
    )

    print("QuickBite:", response.content)
    print()

    turns += 1

print("\nConversation Ended")
print("Total Turns:", turns)

print("\nMemory Buffer\n")

history = get_history(session_id)

for message in history.messages:
    if message.type == "human":
        print("User:", message.content)
    else:
        print("QuickBite:", message.content)