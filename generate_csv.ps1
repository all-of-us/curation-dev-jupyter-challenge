$ErrorActionPreference = "Stop"

$pwd=(get-location)

$cmd_args=@(
    'compose'
)

$build_args=$cmd_args
$build_args+=@(
    'build',
    '--build-arg',
    'UID=1000',
    '--build-arg',
    'GID=1000',
    '--progress',
    'plain',
    '--no-cache',
    'download-csv'
)

& docker @build_args

if ($lastexitcode -ne 0)
{
    write-host "Error(s) occurred during build"
    exit 1
}

$pwd=(get-location)

$run_args=$cmd_args
$run_args+=@(
    'compose',
    'run',
    '-v',
    """${pwd}/repos-csv-output:/repos-csv-output""",
    'download-csv'
)

& docker @run_args