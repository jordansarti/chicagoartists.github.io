import React, { useState } from 'react'
import {groupedArtTerms, groupedCultures} from './menus'

const Sidebar = props =>  {
    const [ showTermList, setShowTermList] = useState('')
    const [ showCultList, setShowCultList] = useState('')
    function filterTerms(e, t){
        e.stopPropagation()
        props.setTermFilter(t)
    }
    function filterCults(e, c){
        e.stopPropagation()
        props.setTermFilter(c)
    }
    function termGroupShow(gt){
        showTermList === gt ? setShowTermList('') : setShowTermList(gt)
    }
    function cultureGroupShow(gc){
        showCultList === gc ? setShowCultList('') : setShowCultList(gc)
    }
    const termMenu = groupedArtTerms.map(gt => {
        const individTerms = gt.ids.map(t => <li key={t} className={t === props.termFilter ? 'selected' : 'notSelected'} onClick={(e) => filterTerms(e, t)}>{t}</li>)
        return <li key={gt.group} onClick={() => termGroupShow(gt.group)}>{gt.name}<br />{(showTermList === gt.group || gt.ids.indexOf(props.termFilter) > -1)&& <ul >{individTerms}</ul>}</li>
    })
    const cultureMenu = groupedCultures.map(gc => {
        const individCultures = gc.ids.map(c => <li key={c} className={c === props.cultFilter ? 'selected' : 'notSelected'} onClick={(e) => filterCults(e, c)}>{c}</li>)
        return <li key={gc.group} onClick={() => cultureGroupShow(gc.group)}>{gc.name}<br />{(showCultList === gc.group || gc.ids.indexOf(props.cultFilter) > -1) && <ul >{individCultures}</ul>}</li>
    })
    return (<div>
        <ul>

        {termMenu}
        </ul>
        <ul>

        {cultureMenu}
        </ul>
    </div>)
}
export default Sidebar