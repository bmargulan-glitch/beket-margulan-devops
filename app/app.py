"""DevOps Student Application: prints student info and serves it over HTTP."""
import os
import socket
from http.server import BaseHTTPRequestHandler, HTTPServer

NAME = os.getenv("STUDENT_NAME", "Margulan")
SURNAME = os.getenv("STUDENT_SURNAME", "Beket")
GROUP = os.getenv("STUDENT_GROUP", "it2-2302")
STUDENT_ID = os.getenv("STUDENT_ID", "38109")
PORT = int(os.getenv("APP_PORT", "5050"))


def banner() -> str:
    line = "=" * 32
    return "\n".join([
        line,
        "DevOps Student Application",
        line,
        "",
        f"Name: {NAME}",
        f"Surname: {SURNAME}",
        f"Group: {GROUP}",
        f"Student ID: {STUDENT_ID}",
        "",
        "Application is running successfully!",
    ])


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/health":
            body = "OK"
        else:
            body = banner() + f"\n\nContainer hostname: {socket.gethostname()}\n"
        data = body.encode()
        self.send_response(200)
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)

    def log_message(self, fmt, *args):
        print(f"INFO Request: {self.address_string()} {fmt % args}", flush=True)


if __name__ == "__main__":
    print(banner(), flush=True)
    print(f"\nINFO Listening on port {PORT}", flush=True)
    HTTPServer(("0.0.0.0", PORT), Handler).serve_forever()
