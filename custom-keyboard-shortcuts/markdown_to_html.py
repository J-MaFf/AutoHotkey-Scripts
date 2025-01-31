import markdown
import sys

def markdown_to_html(markdown_text):
    html = markdown.markdown(markdown_text, extensions=['markdown.extensions.tables'])
    return html

if __name__ == "__main__":
    markdown_text = sys.stdin.read()
    html_content = markdown_to_html(markdown_text)
    html_template = f"""
    <html>
    <head>
        <style>
            table, th, td {{
                border: 1px solid black;
                border-collapse: collapse;
            }}
            th, td {{
                padding: 5px;
                text-align: left;
            }}
        </style>
    </head>
    <body>
        {html_content}
    </body>
    </html>
    """
    print(html_template)