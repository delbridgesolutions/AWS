import subprocess
import threading
import logging

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# Define a function to execute a Python script
def execute_python_script(script_name):
    try:
        logging.info(f"Executing {script_name}")
        subprocess.run(["python", script_name], check=True)
        logging.info(f"Finished {script_name}")
    except subprocess.CalledProcessError as e:
        logging.error(f"Error executing {script_name}: {e}")

# List of Python scripts to execute
scripts_to_execute = ["cronjob_ttl.py", "cronjob.py"]

# Create a list to hold thread objects
threads = []

# Start a thread for each script
for script in scripts_to_execute:
    thread = threading.Thread(target=execute_python_script, args=(script,))
    threads.append(thread)
    thread.start()

# Wait for all threads to finish
for thread in threads:
    thread.join()

logging.info("All scripts have been executed.")