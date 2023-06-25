import React, { useEffect, useState } from 'react';

export default function Session(props) {
    
    const topics = props.topics;
    
    // states
    const [queryType, setQueryType] = useState("are")
    const [queryData, setQueryData] = useState(null)
    const [response, setResponse] = useState('')
    const [responseDisplay, setResponseDisplay] = useState('none')
    const [questionNumber, setQuestionNumber] = useState(Math.floor(Math.random() * 4))
    const [myName, setMyName] = useState("No Name Given")

    // functions
    async function getDataAndDisplayQuestion() {
        setResponseDisplay('none')
        await getData()
        // setQuestion(`Conjugate '${queryData[Math.floor(Math.random() * 4)].italian}' in the 'I' form`)
        setResponseDisplay('block')
    }

    async function getData() {
        fetch(`http://localhost:5000/api/verbs/${queryType}`
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
            <button onClick={() => getDataAndDisplayQuestion()}>Select</button>
            <br></br>
            <div id='answerArea' style={{display:responseDisplay}}>
                <br></br>
                <div>{queryData && `Conjugate '${queryData[questionNumber].english}' in the 'I' form`}</div>
                <input
                    placeholder='type answer here'
                    required
                    value={response}
                    onChange={(e) => setResponse(e.target.value)}
                ></input>
                <button onClick={() => setQuestionNumber(Math.floor(Math.random() * 4))}>Next Question</button>         
            </div>
        
            
        </div>

    )
}