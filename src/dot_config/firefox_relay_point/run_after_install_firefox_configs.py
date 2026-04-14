import os
import sys
from pathlib import Path


def main():
    print(f"{'-' * 40}\nInsatlling Firefox configs\n{'-' * 40}")

    assert Path.cwd() == Path.home() / ".config/firefox_relay_point"

    match sys.platform:
        case "linux":
            profiles_path = Path(os.environ["XDG_CONFIG_HOME"]) / "mozilla/firefox"
        case "win32":
            profiles_path = Path(os.environ["APPDATA"]) / r"Mozilla\Firefox\Profiles"
        case _:
            raise RuntimeError("Unexpected platform:", sys.platform)

    if not profiles_path.exists():
        print(f"Firefox profiles directory not found:\n{profiles_path}")
        return

    root_src_files = [p for p in Path().glob("*") if p.suffix in (".js", ".css")]
    chrome_src_files = list(Path("chrome").glob("*"))

    for profile in profiles_path.glob(
        "[a-z0-9][a-z0-9][a-z0-9][a-z0-9][a-z0-9][a-z0-9][a-z0-9][a-z0-9].*/",
    ):
        for p in root_src_files:
            p.copy(profile / p.name)

        (chrome_dst_dir := profile / "chrome").mkdir(exist_ok=True)
        for p in chrome_src_files:
            p.copy(chrome_dst_dir / p.name)


if __name__ == "__main__":
    main()
