import React, { useEffect, useState } from 'react';

export default function Session(props) {
    
    const topics = props.topics;
    
    // states
    const [queryData, setQueryData] = useState(null)
    const [question, setQuestion] = useState('')
    const [response, setResponse] = useState('')
    const [responseDisplay, setResponseDisplay] = useState('none')
    const [questionNumber, setQuestionNumber] = useState(Math.floor(Math.random() * 4))

    // functions
    async function getDataAndDisplayQuestion() {
        setResponseDisplay('none')
        await getData()
        // setQuestion(`Conjugate '${queryData[Math.floor(Math.random() * 4)].italian}' in the 'I' form`)
        setResponseDisplay('block')
    }

    async function getData() {
        fetch('http://localhost:5000/api/verbs'
        ).then(
            Response => Response.json()
        ).then(
            Data => {
                console.log(Data)
                setQueryData(Data.recordset)
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
                <br></br>
                <div>Question</div>
                <input
                    placeholder='type answer here'
                    required
                    value={response}
                    onChange={(e) => setResponse(e.target.value)}
                ></input>         
            </div>
            <div>
                {(queryData == null) ? "" : (queryData[0].italian)}
            </div>
        
            
        </div>

    )
}