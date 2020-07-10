params.fasta = 'input.fa'

process get_fasta {
    input:
    file bed
    output:
    file "*.fa"
    script:
    """
    bedtools getfasta -name -fi ${params.fasta} -bed $bed -fo ${bed.baseName}.fa
    """
}