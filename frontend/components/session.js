import React, { useEffect, useState } from 'react';

export default function Session(props) {
    
    const topics = props.topics;
    
    // states
    const [answers, setAnswers] = useState(["jamie"])
    const [response, setResponse] = useState('')
    const [responseDisplay, setResponseDisplay] = useState('none')

    // functions
    function getDataAndShowResponseArea() {
        setResponseDisplay('block')
    }

    // html
    return (
        <div>
            <div>Select an option from the dropdown menu</div>
            <br></br>
            <select>
                {topics[0].map((item) => (
                    <option key={item.id}>{item.name}</option>
                ))}
            </select>
            <br></br> <br></br>
            <button onClick={() => getDataAndShowResponseArea()}>Select</button>
            <br></br>
            <div id='answerArea' style={{display:responseDisplay}}> 
                <br></br><br></br>
                <div>What is the Italian translation of: To go</div>
                <input
                    placeholder='type answer here'
                    required
                    value={response}
                    onChange={(e) => setResponse(e.target.value)}
                ></input>
                <button>Submit</button>
            </div>
            
        </div>

    )
}