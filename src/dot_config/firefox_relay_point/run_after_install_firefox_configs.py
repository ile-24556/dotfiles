import os
import subprocess
import sys
from pathlib import Path


def main():
    print(f"{'-' * 40}\nInsatlling Firefox configs\n{'-' * 40}")

    assert Path.cwd() == Path.home() / ".config/firefox_relay_point"

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

    items = [str(p) for p in Path().glob("*") if p.suffix != ".md"]
    item_args = " ".join(items)

    for profile in profiles_path.glob(
        "[a-z0-9][a-z0-9][a-z0-9][a-z0-9][a-z0-9][a-z0-9][a-z0-9][a-z0-9].*/",
    ):
        print(f"Copying {items} into '{profile}'")
        # Use system command to easily overwrite destination files
        if sys.platform == "linux":
            subprocess.run([f"cp -r {item_args} {profile}"], shell=True)
        else:
            subprocess.run(
                [f"Copy-Item -Force -Recurse -Path {item_args} -Destination {profile}"],
                shell=True,
            )


if __name__ == "__main__":
    main()
