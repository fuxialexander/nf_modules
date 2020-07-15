params.motif = 'motif_path'
params.motif_annot = 'motif_annot'
params.outdir = 'results'

process ame {
    publishDir "${params.outdir}/ame", saveAs: { filename -> "${input.baseName}.ame.csv" }
    input:
    tuple file(input), file(control)
    output:
    file("ame_out/ame.csv")
    script:
    """
    ame --control $control $input ${params.motif}
    process_ame.py -f ame_out/ame.tsv -a $params.motif_annot -o ame_out/ame.csv
    """
}
