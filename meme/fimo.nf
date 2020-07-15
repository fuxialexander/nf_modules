params.motif = 'motif_path'
params.motif_annot = 'motif_annot'
params.outdir = 'results'

process fimo {
    publishDir "${params.outdir}/fimo", saveAs: { filename -> "${input.baseName}.fimo.csv" }
    input:
    file input
    output:
    tuple val("${input.baseName}"), path("fimo_out/fimo.csv")
    script:
    """
    fimo ${params.motif} $input
    process_fimo.py -f fimo_out/fimo.tsv -a $params.motif_annot -o fimo_out/fimo.csv
    """
}
