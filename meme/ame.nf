params.conda = 'conda_env_path'
params.motif = 'motif_path'
params.outdir = 'results'

process ame {
    conda "$params.conda"
    publishDir "${params.outdir}/ame", saveAs: { filename -> "${input.baseName}.ame.tsv" }
    input:
    tuple file(input), file(control)
    output:
    file("ame_out/ame.tsv")
    script:
    """
    ame --control $control $input ${params.motif}
    """
}
