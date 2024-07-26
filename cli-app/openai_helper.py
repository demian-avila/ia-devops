import openai
import os
from dotenv import load_dotenv
import re
load_dotenv("secrets.env")


openai.api_key = os.getenv("OPENAI_API_KEY")

def get_terraform_code(prompt):
    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",
        messages=[
            {"role": "system", "content": "You are a helpful assistant specialized in generating Terraform scripts for AWS v5.59.0."
                    "You follow best practices and standards so everything in your terraform scripts is parameterize and all variables mandatory have descriptions, types and defaults. The script must be enough to deploy to terraform, so it need to include provider block and everything to just execute terraform plan and apply"},
            {"role": "user", "content": prompt}
        ],
        max_tokens=800,
        temperature=0.5,
    )

    full_response = response.choices[0].message['content'].strip()
    code_block = extract_code_block(full_response)
    return code_block

def extract_code_block(response):
    match = re.search(r'```hcl(.*?)```', response, re.DOTALL)
    if match:
        return match.group(1).strip()
    else:
        print(response)
        return "No valid Terraform code block found in the response."
