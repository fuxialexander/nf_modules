params.conda = 'conda_env_path'
params.motif = 'motif_path'
params.outdir = 'results'

process fimo {
    conda "$params.conda"
    publishDir "${params.outdir}/fimo", saveAs: { filename -> "${input.baseName}.fimo.tsv" }
    input:
    file input
    output:
    tuple val("${input.baseName}"), path("fimo_out/fimo.tsv")
    script:
    """
    fimo ${params.motif} $input
    """
}