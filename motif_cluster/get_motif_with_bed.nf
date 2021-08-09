params.output='results'
process get_motif_with_bed {
    publishDir "${params.output}/get_motif_with_bed"
    input:
    file bed
    file motif_bed_gz
    output:
    file "*from*.bed"
    script:
    """
    FROM=\$(basename -s .over.chain.gz $chain | sed 's/To.*//')
    TO=\$(basename -s .over.chain.gz $chain | sed 's/.*To//')
    liftOver $bed $chain "\${TO}_from_\${FROM}_${bed.simpleName}.bed" "\${TO}_from_\${FROM}_${bed.simpleName}.bed.unmapped"
    """
}