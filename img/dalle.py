import os
import openai
import sys
import json

openai.api_key = os.getenv("OPENAI_API_KEY")

import os

import openai

PROMPT = sys.argv[1]

openai.api_key = os.getenv("OPENAI_API_KEY")

response = openai.Image.create(
    prompt=PROMPT,
    n=1,
    size="256x256",
)

print(response["data"][0]["url"])
answer = "![image](" + response["data"][0]["url"]+ ")"

with open(".github/comment-template.md", 'a') as f:
    f.write(answer)
