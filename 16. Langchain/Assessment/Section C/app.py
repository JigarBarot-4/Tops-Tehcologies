import json
import requests
import streamlit as st

from langchain_ollama import ChatOllama
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.prompts import MessagesPlaceholder
from langchain_core.chat_history import InMemoryChatMessageHistory
from langchain_core.runnables.history import RunnableWithMessageHistory
from langchain_core.tools import tool


st.set_page_config(
    page_title="QuickBite AI",
    layout="wide"
)


# ---------------- Load Menu ----------------

with open("menu.json", "r") as file:
    menu = json.load(file)


# ---------------- LLM ----------------

llm = ChatOllama(model="mistral")


# ---------------- Memory ----------------

store = {}


def get_history(session_id):

    if session_id not in store:
        store[session_id] = InMemoryChatMessageHistory()

    return store[session_id]


# ---------------- Menu Filter ----------------

def get_menu_items(user_message):

    if not user_message:
        return menu[:3]

    if st.session_state.get("diet") == "Vegetarian":
        filtered = [item for item in menu if item["veg"]]
    else:
        filtered = menu

    for item in filtered:

        if item["cuisine"].lower() in user_message.lower():
            return [item]

    return filtered[:3]


# ---------------- Delivery Tool ----------------

def get_delivery_estimate(distance, item_count, weather):

    url = "http://127.0.0.1:5000/predict"

    if weather.lower() == "rain":
        rain_flag = 1
    else:
        rain_flag = 0

    data = {
        "distance_km": distance,
        "num_items": item_count,
        "rain_flag": rain_flag
    }

    try:

        response = requests.post(url, json=data)

        if response.status_code != 200:
            return f"API Error: {response.text}"

        result = response.json()

        delivery_time = result["predicted_delivery_time_min"]

        return f"Estimated delivery time is {delivery_time} minutes."

    except Exception as e:

        return f"Connection Error: {e}"

prompt = ChatPromptTemplate.from_messages(
    [

        (
            "system",
            """
You are QuickBite AI.

You are a helpful food delivery assistant.

Customer Address:
{address}

Diet:
{diet}

Recommended Menu:
{menu}

Example 1

User:
Recommend vegetarian food.

Assistant:
I recommend Paneer Butter Masala and Veg Biryani.

Example 2

User:
I want Chinese food.

Assistant:
I recommend Hakka Noodles.

Remember previous conversation while answering.
"""
        ),

        MessagesPlaceholder(variable_name="history"),

        (
            "human",
            "{question}"
        )

    ]
)


chain = prompt | llm


chatbot = RunnableWithMessageHistory(

    chain,

    get_history,

    input_messages_key="question",

    history_messages_key="history"

)
# ---------------- Title ----------------

st.title("QuickBite AI - Intelligent Food Delivery Assistant")


# ---------------- Sidebar ----------------

st.sidebar.header("Customer Details")

address = st.sidebar.text_area("Delivery Address")

diet = st.sidebar.selectbox(
    "Dietary Preference",
    ["Vegetarian", "Non-Vegetarian"]
)

st.session_state["address"] = address
st.session_state["diet"] = diet


# ---------------- Chat History ----------------

if "messages" not in st.session_state:
    st.session_state.messages = []

for message in st.session_state.messages:

    with st.chat_message(message["role"]):
        st.write(message["content"])


# ---------------- Chat Input ----------------

user_input = st.chat_input("Ask anything about food...")


if user_input:

    # Save user message
    st.session_state.messages.append(
        {
            "role": "user",
            "content": user_input
        }
    )

    # Get matching menu
    items = get_menu_items(user_input)

    menu_text = ""

    for item in items:

        menu_text += (
            f"{item['name']} | "
            f"{item['cuisine']} | "
            f"₹{item['price']}\n"
        )

    # Ask the LLM
    response = chatbot.invoke(
        {
            "address": st.session_state["address"],
            "diet": st.session_state["diet"],
            "menu": menu_text,
            "question": user_input
        },
        config={
            "configurable": {
                "session_id": "quickbite"
            }
        }
    )

    # Check if user is asking about delivery time
    if (
    "delivery" in user_input.lower()
    or "how long" in user_input.lower()
    or "estimate" in user_input.lower()
    or "take" in user_input.lower()
        ):

        reply = get_delivery_estimate(
        distance=5,
        item_count=3,
        weather="Clear"
    )

    else:

        reply = response.content

    # Save assistant reply
    st.session_state.messages.append(
        {
            "role": "assistant",
            "content": reply
        }
    )

    st.rerun()


# ---------------- Clear Chat ----------------

if st.sidebar.button("Clear Chat"):

    st.session_state.messages = []

    if "quickbite" in store:
        store["quickbite"].clear()

    st.rerun()