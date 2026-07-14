import streamlit as st
from langchain_ollama import OllamaLLM

llm = OllamaLLM(model="mistral")

st.title("QuickBite Dish Description Generator")

dish = st.text_input("Dish Name")

cuisine = st.text_input("Cuisine Type")

length = st.selectbox(
    "Description Length",
    ["Short", "Medium", "Long"]
)

if "result" not in st.session_state:
    st.session_state.result = ""

if "prompt" not in st.session_state:
    st.session_state.prompt = ""


def generate_description():

    prompt = f"""
Dish Name: {dish}

Cuisine Type: {cuisine}

Description Length: {length}

Write an appetising promotional description for this dish.
Write in a customer-friendly tone.
"""

    # Print prompt for debugging
    print(prompt)

    st.session_state.prompt = prompt

    with st.spinner("Generating description..."):

        answer = llm.invoke(prompt)

    st.session_state.result = answer


if st.button("Generate"):
    generate_description()


if st.session_state.result != "":

    with st.container():

        st.subheader("Generated Description")

        st.write(st.session_state.result)

    st.write("Character Count :", len(st.session_state.result))

    if st.button("Regenerate"):
        generate_description()