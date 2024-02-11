from diffusers import StableDiffusionPipeline

def paint(prompt,save_path, target_resolution=(512, 512)):
    print("Painting...")
    
    # Initialize the StableDiffusionPipeline
    pipe = StableDiffusionPipeline.from_pretrained("runwayml/stable-diffusion-v1-5",num_iterations=5)
    pipe = pipe.to("mps")
    pipe.enable_attention_slicing()
    
    # Generate an image based on the provided prompt
    image = pipe(prompt).images[0]

    # Resize the generated image to the target resolution
    resized_image = image.resize(target_resolution)

    # Save the resized image with the specified filename
    resized_image.save(save_path)

if __name__ == "__main__":
    # Example usage:
    prompt = "Draw a beautiful landscape where unicorn are playing with angels"
    user_id = "123"
    target_resolution = (512, 512)  # Set your desired resolution here
    paint(prompt, user_id, target_resolution)
    print("Done!")
