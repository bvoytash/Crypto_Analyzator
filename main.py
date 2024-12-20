import os
import json
import datetime
import re
from collections import Counter
import pandas as pd
from flask import Flask, request, render_template, jsonify
import matplotlib.pyplot as plt

app = Flask(__name__)

UPLOAD_FOLDER = "uploads"
PLOT_FOLDER = "static"
app.config["UPLOAD_FOLDER"] = UPLOAD_FOLDER
app.config["PLOT_FOLDER"] = PLOT_FOLDER


def find_words(text):
    """Find hashtags or dollar-sign prefixed words."""
    match = re.findall(r"[$#][a-zA-Z]\w+", text)
    return match


def process_file(file_path, end_date, most_common_count):
    """Process the uploaded JSON file with parameters."""
    with open(file_path) as file:
        data = json.load(file)

    results = []
    for message in data["messages"]:
        year, month, day = (message["date"][:10]).split("-")
        date_message = datetime.datetime(int(year), int(month), int(day))
        if date_message <= end_date:
            continue
        text = str(message["text"])
        matched_words = find_words(text)
        if matched_words:
            results.extend(matched_words)

    most_common = Counter(results).most_common(most_common_count)
    df = pd.DataFrame(most_common, columns=["Coin", "Count"])

    # Generate plot
    os.makedirs(app.config["PLOT_FOLDER"], exist_ok=True)
    plot_path = os.path.join(app.config["PLOT_FOLDER"], "plot.png")
    plt.figure(figsize=(12, 6))
    plt.bar(df["Coin"], df["Count"], color="skyblue", edgecolor="black")
    plt.xlabel("Coins", fontsize=14)
    plt.ylabel("Frequency", fontsize=14)
    plt.title("Most Common Coins", fontsize=16)
    plt.xticks(rotation=45, ha="right", fontsize=12)
    plt.grid(axis="y", linestyle="--", alpha=0.7)
    plt.tight_layout()
    plt.savefig(plot_path)
    plt.close()

    return df, plot_path


@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        # Retrieve user inputs
        end_date_str = request.form.get("end_date")
        most_common_count = int(request.form.get("most_common", 15))
        end_date = datetime.datetime.strptime(end_date_str, "%Y-%m-%d")

        # Handle file upload
        if "file" not in request.files:
            return "No file part"
        file = request.files["file"]
        if file.filename == "":
            return "No selected file"
        if file:
            file_path = os.path.join(app.config["UPLOAD_FOLDER"], file.filename)
            os.makedirs(app.config["UPLOAD_FOLDER"], exist_ok=True)
            file.save(file_path)

            df, plot_path = process_file(file_path, end_date, most_common_count)
            table_data = df.to_dict(orient="records")

            return jsonify({"table_data": table_data, "plot_url": "/" + plot_path})
    return render_template("index.html")


if __name__ == "__main__":
    app.run(debug=True)