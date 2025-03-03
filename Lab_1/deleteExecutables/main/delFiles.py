import os

folder_path = r'C:\Folders\Facultate\Anul_I\Arhitectura sistemelor de calcul\Laburi\Lab_3\Tema'

files = os.listdir(folder_path)

for file in files:

    file_path = os.path.join(folder_path, file)

    if os.path.isfile(file_path):
        if file.endswith('.exe') or file.endswith('.lst'):
            os.remove(file_path)

print("Delete all executables and lists")
