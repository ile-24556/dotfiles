import os
import subprocess
import sys
from pathlib import Path


def main():
    if (cwd := Path.cwd()) != Path.home() / ".config/firefox_relay_point":
        raise RuntimeError("Unexpected working directory:", cwd)

    match sys.platform:
        case "linux":
            if system_is_wsl():
                print("[Firefox configs] You are in WSL: Skip")
                return
            profiles_path = Path(os.environ["XDG_CONFIG_HOME"]) / "mozilla/firefox"
        case "win32":
            profiles_path = Path(os.environ["APPDATA"]) / r"Mozilla\Firefox\Profiles"
        case _:
            raise RuntimeError(f"[Firefox configs] Unexpected platform: {sys.platform}")

    if not profiles_path.exists():
        print(f"[Firefox configs] Profiles directory not found:\n{profiles_path}")
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


def system_is_wsl() -> bool:
    return subprocess.run(
        ["uname", "-r"],
        capture_output=True,
        check=True,
        encoding="utf_8",
    ).stdout.strip().endswith("-microsoft-standard-WSL2")


if __name__ == "__main__":
    print("[Firefox configs] Installing configs ...")
    main()
    print("[Firefox configs] Done.")
