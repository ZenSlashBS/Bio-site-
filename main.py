import os
from app import app  # imports the Flask app above

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8080))
    # You can hardcode a webhook URL here if you later add a bot, e.g.:
    # app_url = "https://bio-site-production.up.railway.app"
    app.run(host="0.0.0.0", port=port, debug=False)
