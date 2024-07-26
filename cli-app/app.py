from openai_helper import get_terraform_code

def main():
    print("Welcome to the AI-driven Terraform Generator!")
    service = input("Enter the AWS service you want to configure (e.g., VPC, EC2, S3): ")
    details = input("Enter the details for the service (e.g., 'Create a VPC with two subnets'): ")

    prompt = f"As a DevOps engineer, I need to create IaC for {service} in AWS. {details}"
    print(prompt)
    print("\nGenerating Terraform code...\n")

    terraform_code = get_terraform_code(prompt)

    print("Terraform Code Generated:\n")
    print(terraform_code)

    save = input("\nDo you want to save this code to a file? (yes/no): ").strip().lower()
    if save == 'yes':
        file_name = "../iac/main.tf"
        with open(file_name, 'w') as f:
            f.write(terraform_code)
        print(f"Terraform code saved to {file_name}")
        print("you can now go to iac folder and run 'terraform plan' and 'terraform apply' to deploy resources into AWS")

if __name__ == "__main__":
    main()
