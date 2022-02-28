import React, { useState } from 'react'
import { linkArtTerms } from '../data/linkArtTerms'
import { linkCultures } from '../data/linkCultures'
import {artistInfo} from '../data/artistInfo'

const Main = props => {
    const arters = artistInfo.filter(a => {
        let linkedCults = linkCultures.filter(t => t['Culture'] === props.cultFilter).map(c => c['Artist Accession Number'])
        let linkedArtTerms = linkArtTerms.filter(t => t['Art Term'] === props.termFilter).map(t => t['Artists Accession Number'])
        return (props.cultFilter === '' || linkedCults.indexOf(a['Artist Accession Number']) > -1) && (props.termFilter === '' || linkedArtTerms.indexOf(a['Artist Accession Number']) > -1 )
    }).map(a => <Artist data={a} />)

    const [artists, setArtists] = useState(arters)
    return <div>

        {arters}
    </div> 
}

const Artist = ({ data }) => {
    return (
        <div>
            {data.Name}
        </div>
    )
}

export default Main