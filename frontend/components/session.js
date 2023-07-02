import React, { useEffect, useState } from 'react';

export default function Session(props) {

    const topics = props.topics;
    const conjugates = ["i", "youSingular", "theySingular", "we", "youPlural", "theyPlural"]
    const readableConjugates = ["I", "You (singular)", "They (singular)", "We", "You (plural)", "They (plural)"]
    const testLength = 10

    // states

    const [queryType, setQueryType] = useState(props.topics[0][0]["name"]) // type of data to get from the database
    const [isPending, setIsPending] = useState(true) // is data loading, or already loaded
    const [responseAreaDisplay, setResponseAreaDisplay] = useState('none') // area where user can submit answers, is this hidden or not
    const [selectAreaDisplay, setSelectAreaDisplay] = useState('block') // area where user can pick a topic, is this hidden or not

    const [queryData, setQueryData] = useState(null) // data from database
    const [wordNumber, setWordNumber] = useState(0) // the verb from queryData that the user will translate
    const [conjugateNumber, setConjugateNumber] = useState(Math.floor(Math.random() * 6)) // the specific conjugation the user will answer
    const [response, setResponse] = useState('') // the user's answer
    const [score, setScore] = useState(0) // the user's correct answers
    const [total, setTotal] = useState(0) // the total number of questions the user has answered
    const [mostRecentScore, setMostRecentScore] = useState(null) // user's most recent score

    // functions

    async function startTest() {
        setIsPending(true)
        setScore(0)
        setTotal(0)
        setResponse('')

        setConjugateNumber(Math.floor(Math.random() * 6))
        await getData()

        setResponseAreaDisplay('block')
        setSelectAreaDisplay('none')
        setIsPending(false)
    }

    async function endTest() {
        setMostRecentScore(`${100 * (score / total)}%`)
        setSelectAreaDisplay('block')
        setResponseAreaDisplay('none')
        setQueryData(null)
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
        if (total == testLength - 1) {
            endTest()
        } else {
            setResponse("")
            setWordNumber(wordNumber == queryData.length - 1 ? 0 : wordNumber + 1)
            setConjugateNumber(Math.floor(Math.random() * 6))
        }
    }

    // html
    return (
        <div style={{
            display: 'flex',
            justifyContent: 'center'
        }}>
            <div style={{ display: selectAreaDisplay }}>
                <div>Select an option from the dropdown menu</div>
                <div>{mostRecentScore == null
                    ? "Complete a test to see your most recent score"
                    : `Your most recent score is ${mostRecentScore}`
                }</div>
                <br></br>
                <button onClick={() => startTest()}>Select</button>
                <select onChange={(e) => setQueryType(e.target.value)}>
                    {topics[0].map((item) => (
                        <option key={item.id}>{item.name}</option>
                    ))}
                </select>
                <br></br><br></br>
            </div>

            <div id='answerArea' style={{ display: responseAreaDisplay }}>
                <div>{(!isPending && queryData) && `Conjugate '${queryData[wordNumber].english}' in the '${readableConjugates[conjugateNumber]}' form`}</div>
                <br></br>
                <div>
                    <input
                        placeholder='type answer here'
                        required
                        value={response}
                        onChange={(e) => setResponse(e.target.value)}
                    ></input>
                </div>
                <div>
                    <button onClick={() => nextQuestion()}>Submit</button>
                </div>
                <br></br>
                <div>{`Question ${total + 1}`}</div>
            </div>
        </div>

    )
}