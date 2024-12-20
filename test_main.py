import os
import json
import unittest
import shutil
from io import BytesIO
from datetime import datetime
from main import app, find_words, process_file


class FlaskAppTests(unittest.TestCase):
    def setUp(self):
        """Set up the Flask application for testing."""
        self.app = app.test_client()
        self.app.testing = True

    def test_find_words(self):
        """Test find_words function."""
        text = "Invest in #Bitcoin and $Ethereum!"
        expected = ["#Bitcoin", "$Ethereum"]
        result = find_words(text)
        self.assertEqual(result, expected)

    def test_process_file(self):
        """Test process_file function with a sample JSON input."""
        # Create a temporary JSON file
        sample_data = {
            "messages": [
                {"date": "2024-01-01T00:00:00Z", "text": "Invest in #Bitcoin"},
                {"date": "2024-01-02T00:00:00Z", "text": "Buy $Ethereum"},
                {"date": "2023-12-31T00:00:00Z", "text": "Hold $Litecoin"},
            ]
        }

        with open("test.json", "w") as f:
            json.dump(sample_data, f)

        end_date = datetime.strptime("2023-12-31", "%Y-%m-%d")
        most_common_count = 2

        df, plot_path = process_file("test.json", end_date, most_common_count)

        # Check if DataFrame has correct content
        self.assertEqual(len(df), 2)
        self.assertIn("Coin", df.columns)
        self.assertIn("Count", df.columns)

        # Clean up test file
        os.remove("test.json")

    def test_index_post(self):
        """Test the index route for POST requests."""
        data = {
            "end_date": "2024-01-01",
            "most_common": "2",
            "file": (
                BytesIO(
                    b'{"messages":[{"date":"2024-01-01T00:00:00Z","text":"Invest in #Bitcoin"},{"date":"2024-01-02T00:00:00Z","text":"Buy $Ethereum"}]}'
                ),
                "test.json",
            ),
        }

        response = self.app.post("/", data=data, content_type="multipart/form-data")

        self.assertEqual(response.status_code, 200)

        json_response = json.loads(response.data)

        # Check if response contains table_data and plot_url
        self.assertIn("table_data", json_response)
        self.assertIn("plot_url", json_response)

    def tearDown(self):
        """Clean up after each test."""
        if os.path.exists(app.config["UPLOAD_FOLDER"]):
            shutil.rmtree(app.config["UPLOAD_FOLDER"])
        if os.path.exists(app.config["PLOT_FOLDER"]):
            shutil.rmtree(app.config["PLOT_FOLDER"])


if __name__ == "__main__":
    unittest.main()
