from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    return '''
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Hello, World!</title>
            <style>
                body {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
                    margin: 0;
                    font-family: Arial, sans-serif;
                    background-color: #f4f4f4;
                    color: #333;
                }
                h1 {
                    font-size: 3rem;
                    text-align: center;
                    color: #007BFF;
                }
            </style>
        </head>
        <body>
            <h1>Hello, World!100Ms</h1>
        </body>
        </html>
    '''

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
