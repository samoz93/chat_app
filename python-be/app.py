from flask import Flask
from diffusers import StableDiffusionPipeline

app = Flask(__name__,)


def paint(prompt):
    print("Painting...")
    pipe = StableDiffusionPipeline.from_pretrained(
        "runwayml/stable-diffusion-v1-5", 
        use_auth_token=True)

    pipe = pipe.to("mps")

    # Recommended if your computer has < 64 GB of RAM
    pipe.enable_attention_slicing()


    # image = pipe("Draw a mushy mushroom, it should be super trippy and realistic",generator=generator).images[0]
    image = pipe(prompt).images[0]
    image.save("image_of_squirrel_painting.png")

@app.route("/")
def hello_world():
    prompt = "a photo of an astronaut riding a horse on mars"
    paint(prompt)
    return "<p>Hello, World!</p>"


if __name__ == "__main__":
    print("Running app.py")
    app.run(host="0.0.0.0", port=5000)
