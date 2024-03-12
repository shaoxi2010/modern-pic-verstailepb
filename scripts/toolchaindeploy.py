from argparse import ArgumentParser
from subprocess import check_output
from os import path, mkdir, listdir
from shutil import copyfile
parser = ArgumentParser()
parser.add_argument("path", help="toolchain path")
parser.add_argument("deploy_header", help="deploy header path")

def getlibgcc(gccpath):
    out = check_output([gccpath, "-print-libgcc-file-name"])
    return out.decode("utf-8").strip()

if __name__ == "__main__":
    args = parser.parse_args()
    libgcc = getlibgcc(args.path)
    libgcc_dir = path.dirname(libgcc)
    header = path.join(libgcc_dir, "include")

    if not path.exists(args.deploy_header):
        mkdir(args.deploy_header)
    for file in listdir(header):
        if not path.exists(path.join(args.deploy_header, file)):
            copyfile(path.join(header, file), path.join(args.deploy_header, file))