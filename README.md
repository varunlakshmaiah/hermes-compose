<p align="center">
  <img src="assets/banner.png" alt="Hermes AI Agent Banner" width="100%">
</p>

<h1 align="center">🚀 Hermes AI Agent: Zero-Friction Deployment</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Docker-Ready-2496ED?style=for-the-badge&logo=docker&logoColor=white" alt="Docker">
  <img src="https://img.shields.io/badge/Dokploy-Optimized-000000?style=for-the-badge&logo=linux&logoColor=white" alt="Dokploy">
  <img src="https://img.shields.io/badge/Open%20Source-%E2%9D%A4-FF69B4?style=for-the-badge" alt="Open Source">
</p>

Welcome to the easiest, most professional way to self-host the **NousResearch Hermes Agent** and **Hermes Gateway**. 

If you are looking to build, run, and scale your own autonomous AI agent using powerful LLMs (like OpenRouter, OpenAI, or Anthropic), you are in the right place. This repository provides a production-ready, fully optimized Docker Compose template designed for lightning-fast deployments on platforms like [Dokploy](https://dokploy.com/), VPS environments, or your local machine.

## ✨ Why Use This Template? (The "Zero-Friction" Promise)

Normally, self-hosting the NousResearch Hermes Docker image requires you to open an SSH terminal, pull the image, and walk through a tedious, interactive CLI setup wizard to configure your LLM provider and integrations.

**We’ve completely eliminated the CLI setup wizard.** 

By defining all configurations as environment variables, this repository allows you to achieve a **frictionless LLM agent deployment**. Whether you're a seasoned DevOps engineer or a beginner, you can have a fully functional AI Agent and Gateway running in under 3 minutes. Just paste your API keys and hit deploy!

---

## ☁️ How to Deploy on Dokploy (or any VPS)

Deploying the Hermes Agent on a cloud server guarantees it stays online 24/7 to answer messages, process data, and respond to webhooks. Here is the step-by-step guide for Dokploy:

### Step 1: Create the Project
1. Log into your Dokploy dashboard and create a new **Compose Service**.
2. Connect this GitHub repository.

### Step 2: Inject Your Environment Variables
1. Navigate to the **Environment** tab of your Compose service in Dokploy.
2. Copy the contents of the `.env.example` file provided in this repository.
3. Paste the variables into Dokploy and replace the placeholder values with your actual API keys. 
   > **Note:** You MUST provide at least one LLM Provider key (e.g., your `OPENROUTER_API_KEY` or `OPENAI_API_KEY`) for the agent to have a "brain".
4. Click **Save**.

### Step 3: Set up Domains for Web Access (Optional)
If you want to access your Agent Dashboard or receive webhooks from Discord/Telegram via the public internet:
1. Go to the **Domains** tab in Dokploy.
2. Point your custom domain (e.g., `dashboard.yourdomain.com`) to port `9119` (The Hermes Dashboard).
3. Point another domain (e.g., `gateway.yourdomain.com`) to port `8765` (The Hermes Gateway for Webhooks).
4. Dokploy will automatically generate free Let's Encrypt SSL certificates for you!

### Step 4: Deploy!
1. Click **Deploy**. 
2. Dokploy will pull the official `nousresearch/hermes-agent:latest` Docker image. The agent will read your environment variables, bypass the setup wizard entirely, and instantly initialize your database and connections. You're live!

---

## 🔒 Security & Privacy (Important!)

This template is configured with security in mind to prevent unauthorized access and configuration headaches.

### 1. The Gateway Allowlist (Who can talk to your bot?)
By default, the `.env.example` includes `GATEWAY_ALLOW_ALL_USERS=true`, which means **anyone** who finds your Telegram/Discord bot can talk to it and consume your API credits. 
* **To make your bot private:** Delete that line in your `.env` and replace it with `TELEGRAM_ALLOWED_USERS=<your_telegram_id>`. The agent will then go into lockdown and completely ignore messages from strangers. (You can find your numeric Telegram ID by messaging `@userinfobot`).

### 2. Webhooks vs. Long-Polling
This repository is deliberately optimized for **Long-Polling**. You only need to provide your `TELEGRAM_BOT_TOKEN`, and the agent will securely reach out to Telegram to pull messages. 
* **Why this is better:** It completely bypasses Cloudflare firewalls (Bot Fight Mode) and prevents you from needing to expose public webhooks. 
* **Warning:** If you explicitly define a `TELEGRAM_WEBHOOK_URL`, Hermes will enforce strict security and **intentionally crash the gateway** unless you also provide a `TELEGRAM_WEBHOOK_SECRET` to prevent forged requests. We highly recommend sticking to Long-Polling by simply leaving the webhook URL empty!

---

## 💻 Local AI Development Guide

Want to test your AI agent locally on your Mac, Windows, or Linux machine before pushing it to the cloud? It's incredibly simple.

1. Clone this repository and copy the example environment file:
   ```bash
   cp .env.example .env
   ```
2. Open the `.env` file and drop in your API keys (like OpenRouter or OpenAI).
3. **Important Note for Local Testing:** This repository is optimized for Dokploy, which requires the `dokploy-network`. If you are running this locally without Dokploy/Traefik, Docker will throw a "network not found" error. 
   Simply open `docker-compose.yml` and comment out the `dokploy-network` blocks before running:
   ```yaml
   # networks:
   #   dokploy-network:
   #     external: true
   ```
4. Spin up the local environment using Docker Compose:
   ```bash
   docker compose up -d
   ```
5. Access your beautiful new AI Dashboard by visiting: `http://localhost:9119`

### 🔗 Testing Webhooks Locally

If you are developing locally, external platforms (like Telegram or Discord) cannot easily send webhooks to your local `8765` port since your laptop is hidden behind a home router.

To solve this, developers use a free secure tunnel like [Ngrok](https://ngrok.com/):
1. Install Ngrok on your machine.
2. Run this command in your terminal to tunnel traffic to the Hermes Gateway:
   ```bash
   ngrok http 8765
   ```
3. Ngrok will give you a public URL (e.g., `https://xyz123.ngrok.app`).
4. Paste this URL into your Telegram or Discord bot settings to start receiving messages locally!

---

## 📚 Useful Links & Resources

*   [**NousResearch Hermes Official Repo**](https://github.com/NousResearch/Hermes) - The core agent codebase.
*   [**Dokploy Official Website**](https://dokploy.com/) - The easiest self-hosted PaaS.
*   [**Hostinger VPS Hosting**](https://www.hostinger.com/vps-hosting) - Affordable, reliable virtual private servers for hosting Dokploy.
*   [**OpenRouter**](https://openrouter.ai/) - Get API keys for top-tier LLMs to power your agent.
*   [**Ngrok**](https://ngrok.com/) - Essential tunneling for local webhook testing.

---
*Built for the open-source community to make self-hosting AI agents accessible to everyone.*