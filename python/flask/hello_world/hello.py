from flask import Flask, render_template
import pymysql

from IPython import embed
from IPython.terminal.embed import InteractiveShellEmbed

app = Flask(__name__)

@app.route('/')
def hello():
    embed()
    ipshell = InteractiveShellEmbed()
    print('start interactive shell')
    db = pymysql.connect(
            host='localhost',
            user='root',
            db='python_test_app',
            charset='utf8',
            cursorclass=pymysql.cursors.DictCursor,
            )
    cur = db.cursor()
    sql = 'select * from members'
    cur.execute(sql)
    members = cur.fetchall()
    db.close()

    name = "hello wordld"
    return render_template('hello.html', title='darui', name=name)

@app.route('/good')
def good():
    name = "good"
    return name

if __name__ == "__main__":
    app.run(debug=True, port=6001)
