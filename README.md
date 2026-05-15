# Hermes Agent & Gateway Configuration

This repository is configured to deploy the official **NousResearch Hermes Agent** and **Hermes Gateway** instantly via [Dokploy](https://dokploy.com/). 

## ⚡ Zero-Friction Deployment

Traditionally, setting up Hermes involves pulling the image, opening a terminal, and walking through an interactive CLI setup wizard to configure your LLM provider and integrations.

**We have bypassed this completely.** By defining all necessary configurations as environment variables, this repository allows you to deploy a fully functional AI Agent and Gateway in under 3 minutes with zero CLI access required.

### Deployment Steps (Dokploy)

#### Step 1: Create the Project
1. In your Dokploy dashboard, create a new **Compose Service**.
2. Connect this GitHub repository.

#### Step 2: Inject the Environment Variables
1. Go to the **Environment** tab of your Compose service in Dokploy.
2. Copy the contents of the `.env.example` file from this repository.
3. Replace the placeholder values with your actual API keys. **You MUST provide at least one LLM Provider key** (e.g., your `OPENROUTER_API_KEY` or `OPENAI_API_KEY`).
4. Click **Save**.

#### Step 3: Set up Domains (Optional)
If you want to access the Dashboard or the Gateway webhooks via the internet:
1. Go to the **Domains** tab.
2. Point your custom domain (e.g., `dashboard.yourdomain.com`) to port `9119` (Dashboard).
3. Point another domain (e.g., `gateway.yourdomain.com`) to port `8765` (Gateway Webhooks).
4. Dokploy will automatically generate free Let's Encrypt SSL certificates.

#### Step 4: Deploy
1. Click **Deploy**. Dokploy will pull the official `nousresearch/hermes-agent:latest` image and start it up. 
2. The agent will read your environment variables, automatically skip the CLI wizard, and initialize your connections!

---

## 🛠️ Local Development

If you want to test the Agent locally on your machine before pushing to Dokploy:

1. Copy the `.env.example` file to `.env`:
   ```bash
   cp .env.example .env
   ```
4. Fill in your API keys in the `.env` file.
5. Start the containers:
   ```bash
   docker compose up -d
   ```
6. Access the dashboard at `http://localhost:9119`.

### Testing Webhooks Locally

If you are developing locally on your laptop, external platforms (like Telegram or Discord) cannot send webhooks to your local `8765` port. 

To solve this, use a free secure tunnel like [Ngrok](https://ngrok.com/):
1. Install Ngrok.
2. Run `ngrok http 8765` in your terminal.
3. Ngrok will give you a public URL (e.g., `https://xyz123.ngrok.app`).
4. Provide this URL to your webhook providers!
