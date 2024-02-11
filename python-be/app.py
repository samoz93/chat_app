from flask import Flask,request, jsonify,send_file
from util.painter import paint
from util.web_util import token_required
from util.db_util import can_paint,init_db
import threading
import os.path
from pathlib import Path



app = Flask(__name__,)

app.config['SECRET_KEY'] = 'samozIsStrugglingWithLife'  # Change this to a secure secret key
app.config['UPLOAD_FOLDER'] = "rooms"

init_db()

def getFilePath(userId,room):
    pth = os.path.join(app.config['UPLOAD_FOLDER'] ,userId)
    if not os.path.exists(pth):
        os.makedirs(pth)
    return pth + "/{}.png".format(room)


@app.route("/", methods=["GET", "POST"])
@token_required
def hello_world(user_data):
    # Get the prompt from the query string
    room = request.args.get("room")
    
    if(not room):
        return jsonify({"error": "Room not found"}), 400

    if request.method == "GET":
        userId = user_data['id']
        pth = getFilePath(userId,room)
        if os.path.isfile(pth):
            return send_file(pth,mimetype='image/png')
        return jsonify({"error":"Image not found"}),404    
    
    
    prompt = request.args.get("prompt")
    
    if(not prompt):
        return jsonify({"error": "Prompt not found"}), 400

    # Get the user id from the token
    userId = user_data['id']
    
    # Simple Authorization
    if not userId:
        return jsonify({"error": "User not found"}), 401
    
    save_path = getFilePath(userId,room)

    # If the user has not requested a painting, create a new job
    if can_paint(userId,room):
        threading.Thread(target=paint, args=(prompt,save_path)).start()
        return jsonify({"status": "Painting in progress"}), 201
    else:
        return jsonify({"status":"Painting is on the way"}) if not os.path.isfile(save_path) else send_file(save_path,mimetype='image/png')

@app.route("/rooms")
@token_required
def get_rooms(user_data):
    userId = user_data['id']
    pth = os.path.join(app.config['UPLOAD_FOLDER'] ,userId)
    if not os.path.exists(pth):
        return jsonify({"rooms":[]})
    return jsonify({"rooms":list(map(lambda x: "{}.png".format(x.stem,),Path(pth).glob("*.png")))})

@app.route("/rooms/<room>")
@token_required
def get_room(user_data,room):
    userId = user_data['id']
    pth = getFilePath(userId,room)
    if os.path.isfile(pth):
        return send_file(pth,mimetype='image/png')
    return jsonify({"error":"Room not found"}),404

if __name__ == "__main__":
    print("Running app.py")
    app.run(port=8000, debug=True)
