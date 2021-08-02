params.output='results'
process liftover_bed {
    publishDir "${params.output}/liftover"
    input:
    file bed
    file chain
    output:
    file "*from*.bed"
    script:
    """
    FROM=\$(basename -s .over.chain.gz $chain | sed 's/To.*//')
    TO=\$(basename -s .over.chain.gz $chain | sed 's/.*To//')
    liftOver $bed $chain "\${TO}_from_\${FROM}_${bed.simpleName}.bed" "\${TO}_from_\${FROM}_${bed.simpleName}.bed.unmapped"
    """
}