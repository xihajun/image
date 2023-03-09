import os
import openai
import sys
import json

openai.api_key = os.getenv("OPENAI_API_KEY")
data = json.loads("comments.json")

# Generate the desired format
conversations = []
for item in data:
    if item["user"]["login"] != "github-actions[bot]":
        conversations.append({"role": "user", "content": item["body"]})
    else:
        conversations.append({"role": "assistant", "content": item["body"]})
print(conversations)

# Run gpt3.5
openai.ChatCompletion.create(
  model="gpt-3.5-turbo",
  messages=conversations
)

anwser = completion.choices[0].message.content
print(anwser)

with open(".github/comment-template.md", 'a') as f:
    f.write(answer)
