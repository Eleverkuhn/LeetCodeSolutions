SELECT sample_id, dna_sequence, species,

    CASE
      WHEN SUBSTR(dna_sequence, 0, 4) = 'ATG' THEN 1 ELSE 0
    END as has_start,

    CASE
      WHEN SUBSTR(dna_sequence, LENGTH(dna_sequence) - 2, LENGTH(dna_sequence))
        IN ('TAA', 'TAG', 'TGA')
      THEN 1
      ELSE 0
    END as has_stop,

    CASE
      WHEN dna_sequence LIKE '%ATAT%' THEN 1 ELSE 0
    END as has_atat,

    CASE
      WHEN dna_sequence LIKE '%GGG%' THEN 1 ELSE 0
    END as has_ggg

FROM samples
ORDER BY sample_id ASC
