import os
import time
import hashlib
import pyperclip
import openai 

# Load your OpenAI API key from the environment
# export OPENAI_API_KEY="your_api_key"
client = openai.OpenAI(api_key=HIDDEN)

POLL_INTERVAL = 5.0  # seconds


def get_clipboard_hash(text: str) -> str:
    return hashlib.sha256(text.encode("utf-8")).hexdigest()



def ask_gpt_for_code(prompt: str) -> str:
    """
    Use the standard chat endpoint to generate only code based on the prompt.
    """
    system_msg = (
        """
        Act as an expert Python developer and help to design and create code blocks / modules as per the user specification.

        RULES:
        - MUST provide clean, production-grade, high quality code.
        - ASSUME the user is using python version 3.12+
        - USE well-known python design patterns and object-oriented programming approaches
        - MUST provide code blocks with input and return value type hinting.
        - PREFER to use F-string for formatting strings
        - PREFER keeping functions Small: Each function should do one thing and do it well.
        - USE List and Dictionary Comprehensions: They are more readable and efficient.
        - Ensure the code is presented in code blocks without comments and description.
        """
    )
    response = client.chat.completions.create(
        model="gpt-4o-mini",            # o "gpt-4"
        messages=[
            {"role": "system", "content": system_msg},
            {"role": "user",   "content": prompt}
        ],
        temperature=0.7,
        max_tokens=1500
    )
    return response.choices[0].message.content.strip()

def main():
    last_hash = None
    text_old = ""
    print("Monitoring clipboard for code prompts. Press Ctrl+C to exit.")
    try:
        while True:
            text = pyperclip.paste()
            print(f"Clipboard content: {text}") if text_old != text else None
            if text:
                current_hash = get_clipboard_hash(text)
                if current_hash != last_hash:
                    last_hash = current_hash
                    print("\n\n\n\t\tNew clipboard content detected; querying ChatGPT...\n\n")
                    code_solution = ask_gpt_for_code(text)
                    pyperclip.copy(code_solution)
                    print("Clipboard updated with code solution.")
            time.sleep(POLL_INTERVAL)
            text_old = pyperclip.paste()
            print(f"Clipboard content: {text_old}") if text_old != text else None
    except KeyboardInterrupt:
        print("Exiting.")

if __name__ == "__main__":
    main()