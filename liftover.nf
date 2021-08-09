params.chain_dir='input/common/chain'
process liftover_bed {
    input:
    file bed
    file chain
    output:
    file "*from*.bed"
    script:
    """
    FROM=\$(basename -s .over.chain.gz $chain | sed 's/To.*//')
    TO=\$(basename -s .over.chain.gz $chain | sed 's/.*To//')
    liftOver $bed $chain "\${TO}.lift_from.${bed.baseName}.bed" "\\${TO}.lift_from.${bed.baseName}.bed.unmapped"
    """
}

process liftover_bedplus3 {
    input:
    file bed
    file chain
    output:
    file "*from*.bed"
    script:
    """
    FROM=\$(basename -s .over.chain.gz $chain | sed 's/To.*//')
    TO=\$(basename -s .over.chain.gz $chain | sed 's/.*To//')
    liftOver -bedPlus=3 -tab $bed $chain "\${TO}.lift_from.${bed.baseName}.bed" "\${TO}.lift_from.${bed.baseName}.bed.unmapped"
    """
}

workflow liftover_bedplus3_hg19_hg38 {
    take: bed
    main:
    chain = Channel.fromPath("$params.chain_dir/hg19ToHg38.over.chain.gz")
    liftover_bedplus3(bed, chain)
    emit:
    liftover_bedplus3.out
}

workflow liftover_bedplus3_hg38_hg19 {
    take: bed
    main:
    chain = Channel.fromPath("$params.chain_dir/hg38ToHg19.over.chain.gz")
    liftover_bedplus3(bed, chain)
    emit:
    liftover_bedplus3.out
}

workflow liftover_bed_hg19_hg38 {
    take: bed
    main:
    chain = Channel.fromPath("$params.chain_dir/hg19ToHg38.over.chain.gz")
    liftover_bed(bed, chain)
    emit:
    liftover_bed.out
}

workflow liftover_bed_hg38_hg19 {
    take: bed
    main:
    chain = Channel.fromPath("$params.chain_dir/hg38ToHg19.over.chain.gz")
    liftover_bed(bed, chain)
    emit:
    liftover_bed.out
}

