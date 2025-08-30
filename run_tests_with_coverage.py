import os
import re
import subprocess

def find_all_files(directory):
    all_files = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            all_files.append(os.path.join(root, file))
    return all_files

def find_cov_files(path):
    with open(path, "r") as file:
        content = file.read()

    return re.findall(r"(?<=SF:)(.+)", content)
    

if __name__ == "__main__":
    cwd = os.path.abspath(os.getcwd())
    command = ["fvm", "flutter", "test"] + find_all_files('test/') + ["--coverage"]
    subprocess.run(command, cwd=cwd)

    # Add uncovered files to report
    project_files = find_all_files("lib/")
    covered_files = find_cov_files("coverage/lcov.info")
    for covered_file in covered_files:
        project_files.remove(covered_file)

    with open("coverage/lcov.info", "a") as file:
        for uncovered_file in project_files:
            file.write(f"SF:{uncovered_file}\nDA:1,0\nend_of_record\n")

    subprocess.run(["genhtml", "coverage/lcov.info", "-o", "coverage/html"], cwd=cwd)
    subprocess.run(["open", "coverage/html/index.html"], cwd=cwd)