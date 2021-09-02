"""Test basic container API."""
import json
from flask import Flask

app = Flask(__name__)


@app.route('/<myname>')
def main(myname: str) -> str:
    """
    Test basic container API.

    return str
    """
    status_code = 200
    status = (
        'Howdy, {}!'
        .format(myname)
    )

    return json.dumps(
        {'message': status},
        default=str
    )


if __name__ == '__main__':
    response = main(
        'test_name'
    )
    print(response)
