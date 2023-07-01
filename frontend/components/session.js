import React, { useEffect, useState } from 'react';

export default function Session(props) {

    const topics = props.topics;
    const conjugates = ["i", "youSingular", "theySingular", "we", "youPlural", "theyPlural"]
    const readableConjugates = ["I", "You (singular)", "They (singular)", "We", "You (plural)", "They (plural)"]

    // states
    const [queryType, setQueryType] = useState(props.topics[0][0]["name"])
    const [isPending, setIsPending] = useState(true)
    const [responseDisplay, setResponseDisplay] = useState('none')

    const [queryData, setQueryData] = useState(null)
    const [wordNumber, setWordNumber] = useState(0)
    const [conjugateNumber, setConjugateNumber] = useState(Math.floor(Math.random() * 6))
    const [response, setResponse] = useState('')
    const [score, setScore] = useState(0)
    const [total, setTotal] = useState(0)

    // functions
    async function getDataAndDisplayQuestion() {
        setResponseDisplay('none')
        setIsPending(true)
        await getData()
        // setQuestion(`Conjugate '${queryData[Math.floor(Math.random() * 4)].italian}' in the 'I' form`)
        setResponseDisplay('block')
        setIsPending(false)
        setScore(0)
        setTotal(0)
    }

    async function getData() {
        fetch(`http://localhost:5000/api/verbs/${queryType}`
        ).then(
            Response => Response.json()
        ).then(
            Data => {
                console.log(Data)
                setQueryData(cleanData(Data.recordset))
            }
        )
    }

    function cleanData(inputArray) {
        for (let i = 0; i < inputArray.length; i++) {
            for (let key in inputArray[i]) {
                inputArray[i][key] = typeof inputArray[i][key] == "string" ? inputArray[i][key].trim().toLowerCase() : inputArray[i][key]
            }
        }
        return inputArray
    }

    function nextQuestion() {
        setScore(response.toLocaleLowerCase().trim() == queryData[wordNumber][conjugates[conjugateNumber]] ? score + 1 : score)
        setTotal(total + 1)
        setResponse("")
        setWordNumber(wordNumber == queryData.length - 1 ? 0 : wordNumber + 1)
        setConjugateNumber(Math.floor(Math.random() * 6))
    }

    useEffect(() => {
        //Runs only on the first render
      }, [])

    // html
    return (
        <div>
            <div>
                <div>Select an option from the dropdown menu</div>
                <br></br>
                <button onClick={() => getDataAndDisplayQuestion()}>Select</button>
                <select onChange={(e) => setQueryType(e.target.value)}>
                    {topics[0].map((item) => (
                        <option key={item.id}>{item.name}</option>
                    ))}
                </select>
                <br></br><br></br>
            </div>
            
            <div id='answerArea' style={{ display: responseDisplay }}>
                <br></br>
                <div>{isPending && "Data is loading..."}</div>
                <div>{(!isPending && queryData) && `Conjugate '${queryData[wordNumber].english}' in the '${readableConjugates[conjugateNumber]}' form`}</div>
                <input
                    placeholder='type answer here'
                    required
                    value={response}
                    onChange={(e) => setResponse(e.target.value)}
                ></input>
                <button onClick={() => nextQuestion()}>Submit</button>
                <br></br>
                <div>{`${score} out of ${total}`}</div>
            </div>
        </div>

    )
}