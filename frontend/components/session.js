import React, { useEffect, useState } from 'react';

export default function Session(props) {
    
    const topics = props.topics;
    
    // states
    const [answers, setAnswers] = useState(null)
    const [question, setQuestion] = useState('')
    const [response, setResponse] = useState('')
    const [responseDisplay, setResponseDisplay] = useState('none')

    // functions
    async function getDataAndDisplayQuestion() {
        setResponseDisplay('none')
        await getData()
        setResponseDisplay('block')
    }

    function getData() {
        fetch('http://localhost:5000/api/verbs').then(
            Response => Response.json()
        ).then(
            Data => {
                console.log(Data)
                setAnswers(Data.recordset)
            }
        )
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
            <button onClick={() => getDataAndDisplayQuestion()}>Select</button>
            <br></br>
            <div id='answerArea' style={{display:responseDisplay}}> 
                <br></br><br></br>
                <div>Conjugate the {question}</div>
                <input
                    placeholder='type answer here'
                    required
                    value={response}
                    onChange={(e) => setResponse(e.target.value)}
                ></input>
                <button>Submit</button>
            </div>
            <div>
                {(answers == null) ? "" : (answers[0].italian)}
            </div>
        
            
        </div>

    )
}