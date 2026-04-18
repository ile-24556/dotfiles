import subprocess
from collections.abc import Generator, Iterable
from pathlib import Path


def main():
    unmanaged_ret = chezmoi(["unmanaged"])
    unmanaged_paths = collect_non_root_files(unmanaged_ret.stdout.splitlines())

    managed_ret = chezmoi(["managed"])
    managed_paths = collect_non_root_files(managed_ret.stdout.splitlines())

    results = prepend_home_tilde(collect_siblings(unmanaged_paths, managed_paths))

    print(
        "",
        "Unmanaged sibling files of a managed file",
        (hr := "-" * 48),
        *results,
        hr,
        sep="\n",
    )


def chezmoi(args: list[str]) -> subprocess.CompletedProcess[str]:
    """Call `chezmoi` command."""
    return subprocess.run(
        ("chezmoi", *args),
        capture_output=True,
        check=True,
        encoding="utf_8",
    )


def collect_non_root_files(paths: Iterable[str]) -> Generator[Path]:
    """Collect non-root paths that point existing files."""
    for e in paths:
        p = Path(e)
        if len(p.parts) > 1 and p.is_file():
            yield p


def collect_siblings(
    unmanaged: Iterable[Path],
    managed: Iterable[Path],
) -> Generator[Path]:
    """Collect unmanaged paths that shares their parent with a managed path."""
    managed = tuple(managed)
    for um in unmanaged:
        for m in managed:
            if um.parent == m.parent:
                yield um
                break


def prepend_home_tilde(paths: Iterable[Path], tilde=Path("~")) -> Generator[Path]:
    """Prepend tilde to easily copy printed path string as an absolute path.

    Note that they are not `Path` objects pointing existing paths since `pathlib`
    does not treat `~` as a home directory until `expanduser()` is called.
    """
    for p in paths:
        yield tilde / p


if __name__ == "__main__":
    main()
