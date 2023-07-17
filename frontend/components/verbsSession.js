import React, { useEffect, useState } from 'react';
import { Link } from '@chakra-ui/next-js'
import { Button, ButtonGroup } from '@chakra-ui/react'
import { Select } from '@chakra-ui/react'
import { Input } from '@chakra-ui/react'
import { Heading } from '@chakra-ui/react';
import {
    FormControl,
    FormLabel,
    FormErrorMessage,
    FormHelperText,
} from '@chakra-ui/react'
import { Card, CardHeader, CardBody, CardFooter } from '@chakra-ui/react'

export default function VerbsSession(props) {

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
    const [resultString, setResultString] = useState("")

    // effects

    useEffect(() => {
        console.log(`Current score is ${score}`)
    }, [score])

    useEffect(() => {
        console.log(`Current total is ${total}`)
        if (total == 10) {
            setMostRecentScore(`${100 * (score / total)}%`)
        }
    }, [total])

    useEffect(() => {
        if (queryData == null) {
            setIsPending(true)
        } else {
            setIsPending(false)
        }
    }, [queryData])

    useEffect(() => {
        setSelectAreaDisplay(isPending ? 'block' : 'none')
        setResponseAreaDisplay(isPending ? 'none' : 'block')
    }, [isPending])

    // functions

    async function startTest() {
        setIsPending(true)
        setScore(0)
        setTotal(0)
        setWordNumber(0)
        setResponse('')

        setConjugateNumber(Math.floor(Math.random() * 6))
        getData()
    }

    async function endTest() {
        setSelectAreaDisplay('block')
        setResponseAreaDisplay('none')
        setQueryData(null)
        setResultString("")
    }

    async function endTestWithoutScore() {
        setSelectAreaDisplay('block')
        setResponseAreaDisplay('none')
        setQueryData(null)
        setResultString("")
    }

    async function getData() {
        try {
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
        catch {
            console.log("There was an error connecting to the database.")
        }
    }

    function cleanData(inputArray) {
        for (let i = 0; i < inputArray.length; i++) {
            for (let key in inputArray[i]) {
                inputArray[i][key] = typeof inputArray[i][key] == "string" ? inputArray[i][key].trim().toLowerCase() : inputArray[i][key]
            }
        }
        return inputArray
    }

    async function nextQuestion() {
        setScore(response.toLocaleLowerCase().trim() == queryData[wordNumber][conjugates[conjugateNumber]] ? score + 1 : score)
        setTotal(total + 1)
        setResultString(response.toLocaleLowerCase().trim() == queryData[wordNumber][conjugates[conjugateNumber]] ? resultString + "/" : resultString + "X")
        if (wordNumber === testLength - 1) {
            endTest()
        } else {
            setResponse("")
            setWordNumber(wordNumber + 1)
            setConjugateNumber(Math.floor(Math.random() * 6))
        }
    }

    // html
    return (
        <div >
            <FormControl id='selectArea' style={{
                display: selectAreaDisplay
            }} p="10">
                <FormLabel >Select an option from the dropdown menu</FormLabel>
                <FormLabel >{mostRecentScore === ""
                    ? "Complete a test to see your most recent score"
                    : `Your most recent score is ${mostRecentScore}`
                }</FormLabel>
                <br></br>
                <Button onClick={() => startTest()}>Select</Button>
                <br></br> <br></br>
                <Select onChange={(e) => setQueryType(e.target.value)}>
                    {topics[0].map((item) => (
                        <option key={item.id}>{item.name}</option>
                    ))}
                </Select>
                <br></br><br></br>
            </FormControl>

            <FormControl id='responseArea' style={{
                display: responseAreaDisplay
            }} p="10">
                <FormLabel>{(!isPending && queryData) && `Translate '${queryData[wordNumber].english}' in the '${readableConjugates[conjugateNumber]}' form`}</FormLabel>
                <br></br>
                <Input
                    placeholder='type answer here'
                    required
                    value={response}
                    onChange={(e) => setResponse(e.target.value)}
                ></Input>
                <br></br> <br></br>
                <ButtonGroup>
                    <Button onClick={() => nextQuestion()}>Submit</Button>
                    <Button onClick={() => endTest()}>End test</Button>
                </ButtonGroup>
                <br></br>
                <FormHelperText >{`Question ${total + 1} out of 10`}</FormHelperText>
                <br></br>
                <FormHelperText >{resultString}</FormHelperText>
            </FormControl>
        </div>

    )
}