import os
import subprocess
import sys
from pathlib import Path


def main():
    match sys.platform:
        case "linux":
            profiles_path = Path(os.environ["XDG_CONFIG_HOME"]) / "mozilla/firefox"
        case "windows":
            profiles_path = Path(os.environ["APPDATA"]) / r"Mozilla\Firefox\Profiles"
        case _:
            raise RuntimeError("Unexpected platform:", sys.platform)

    if not profiles_path.exists():
        print(f"Firefox profiles directory not found:\n{profiles_path}")
        return

    chezmoi_dir = Path.home() / ".local/share/chezmoi"
    items = " ".join(str(p) for p in (chezmoi_dir / "manual_install/firefox").glob("*"))

    for profile in profiles_path.glob("*.default*"):
        # Use system command to easily overwrite destination files
        if sys.platform == "linux":
            subprocess.run([f"cp -r {items} {profile}"], shell=True)
        else:
            subprocess.run(
                [f"Copy-Item -Force -Recurse -Path {items} -Destination {profile}"],
                shell=True,
            )


if __name__ == "__main__":
    main()
