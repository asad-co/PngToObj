import bpy

# Load background images into the scene for reference
def load_reference_images(front_img, side_img, top_img):
    bpy.ops.object.select_all(action='DESELECT')
    bpy.ops.object.delete()  # Clear existing objects

    # Set up orthographic cameras for each view with images
    for img, axis in zip([front_img, side_img, top_img], ["FRONT", "RIGHT", "TOP"]):
        bpy.ops.object.camera_add()
        cam = bpy.context.object
        cam.data.show_background_images = True
        bg = cam.data.background_images.new()
        bg.image = bpy.data.images.load(img)
        bg.display_depth = 'FRONT'
        cam.rotation_euler = view_orientation(axis)

def view_orientation(axis):
    orientations = {
        "FRONT": (0, 0, 0),
        "RIGHT": (0, 1.5708, 0),
        "TOP": (1.5708, 0, 0)
    }
    return orientations[axis]

load_reference_images('./pngs/front.png', './pngs/side.png', './pngs/top.png')


