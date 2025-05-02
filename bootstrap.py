import logging
import sys
from pathlib import Path


def get_logger():
    """Return a `Logger` object for this script."""
    logger = logging.getLogger(__name__)
    logger.setLevel(logging.INFO)
    handler = logging.StreamHandler(sys.stdout)
    formatter = logging.Formatter(
        "%(asctime)s  %(levelname)s  %(name)s.%(funcName)s.%(lineno)d  %(message)s",
        datefmt="%Y-%m-%dT%H:%M:%S%z",
    )
    handler.setFormatter(formatter)
    logger.addHandler(handler)
    return logger


def usage(script_name: str):
    """Display usage message."""
    print(
        f"""Usage: python3 {script_name} [OPTION]
  -a    actually run
  -h    display this help and exit"""
    )


def check_os(logger: logging.Logger):
    """Check if the OS is expected one. If not, exit with error."""
    for line in Path("/etc/os-release").read_text(encoding="UTF-8").splitlines():
        if line == 'NAME="Ubuntu"':
            break
    else:
        logger.error("Unexpected OS")
        sys.exit(1)


def link(targets_dir: Path, links_dir: Path, pretends: bool, logger: logging.Logger):
    """Create symlinks to this repo's files."""
    for target in targets_dir.iterdir():
        link_name = links_dir / target.name
        logger.info(f"Removing '{link_name}'")
        if not pretends:
            link_name.unlink(missing_ok=True)
        logger.info(f"Making '{link_name}' a symlink to '{target}'")
        if not pretends:
            link_name.symlink_to(target)


def remove_file(path: Path, pretends: bool, logger: logging.Logger):
    """Remove a file."""
    logger.info(f"Removing {path}")
    if not pretends:
        path.unlink(missing_ok=True)


def main():
    logger = get_logger()

    check_os(logger)

    needs_help = any(a == "-h" for a in sys.argv[1:])
    if needs_help:
        usage(sys.argv[0])
        return

    pretends = not any(a == "-a" for a in sys.argv[1:])
    if pretends:
        logger.info("Pretending")
    else:
        logger.info("Actually running")

    repo_dir = Path(__file__).parent.resolve()
    home = Path.home()
    link(repo_dir / "home", home, pretends, logger)
    link(repo_dir / "xdg_config_home", home / ".config", pretends, logger)

    remove_file(home / ".gitconfig", pretends, logger)

    logger.info("Done")


if __name__ == "__main__":
    main()
