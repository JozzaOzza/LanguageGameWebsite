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

export default function Session(props) {

    const topics = props.topics;

    // ----------------------------------------------------------------------
    // states

    const [queryType, setQueryType] = useState(props.topics[0][0]["name"]) // type of data to get from the database
    const [isPending, setIsPending] = useState(true) // is data loading, or already loaded
    const [responseAreaDisplay, setResponseAreaDisplay] = useState('none') // area where user can submit answers, is this hidden or not
    const [selectAreaDisplay, setSelectAreaDisplay] = useState('block') // area where user can pick a topic, is this hidden or not

    const [queryData, setQueryData] = useState(null) // data from database
    const [testLength, setTestLength] = useState(0)
    const [wordNumber, setWordNumber] = useState(0) // the word from queryData that the user will translate
    const [response, setResponse] = useState('') // the user's answer
    const [score, setScore] = useState(0) // the user's correct answers
    const [total, setTotal] = useState(0) // the total number of questions the user has answered
    const [mostRecentScore, setMostRecentScore] = useState("") // user's most recent score
    const [resultString, setResultString] = useState("")

    // ----------------------------------------------------------------------
    // effects

    useEffect(() => {
        console.log(`Current score is ${score}`)
    }, [score])

    useEffect(() => {
        console.log(`Current total is ${total}`)
        if (total >= testLength && testLength > 0) {
            setMostRecentScore(`${Math.round(100 * (score / total))}%`)
        }
    }, [total])

    useEffect(() => {
        if (queryData == null) {
            setIsPending(true)
        } else {
            setIsPending(false)
            setTestLength(queryData.length)
        }
    }, [queryData])

    useEffect(() => {
        setSelectAreaDisplay(isPending ? 'block' : 'none')
        setResponseAreaDisplay(isPending ? 'none' : 'block')
    }, [isPending])

    // ----------------------------------------------------------------------
    // functions

    function startTest() {
        setIsPending(true)
        setScore(0)
        setTotal(0)
        setWordNumber(0)
        setResponse('')

        getData()
    }

    async function endTest() {
        setSelectAreaDisplay('block')
        setResponseAreaDisplay('none')
        setQueryData(null)
        setResultString("")
    }

    function getData() {
        try {
            fetch(`http://localhost:5000/api/${topics[1]}/${queryType}`
            ).then(
                Response => Response.json()
            ).then(
                Data => {
                    console.log(Data)
                    setQueryData(cleanData(Data.recordset))
                }
            )
            console.log(`${topics[1]} ${queryType}`)
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
        setScore(response.toLocaleLowerCase().trim() == queryData[wordNumber].italian || response.toLocaleLowerCase().trim() == queryData[wordNumber].alternatives ? score + 1 : score)
        setTotal(total + 1)
        setResultString(response.toLocaleLowerCase().trim() == queryData[wordNumber].italian || response.toLocaleLowerCase().trim() == queryData[wordNumber].alternatives ? resultString + "/" : resultString + "X")
        if (wordNumber === testLength - 1) {
            endTest()
        } else {
            setResponse("")
            setWordNumber(wordNumber + 1)
        }
    }

    // ----------------------------------------------------------------------
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
                <FormHelperText >{`${topics[1].charAt(0).toUpperCase() + topics[1].slice(1)} - ${queryType.charAt(0).toUpperCase() + queryType.slice(1)}`}</FormHelperText>
                <br></br>
                <FormLabel>{(!isPending && queryData) && `Translate '${queryData[wordNumber].english}'`}</FormLabel>
                <br></br>
                <Input
                    placeholder='type answer here'
                    required
                    value={response}
                    onChange={(e) => setResponse(e.target.value)}
                ></Input>
                <br></br> <br></br>
                <ButtonGroup>
                    <Button onClick={() => setResponse(response + 'à')}>à</Button>
                    <Button onClick={() => setResponse(response + 'è')}>è</Button>
                    <Button onClick={() => setResponse(response + 'é')}>é</Button>
                    <Button onClick={() => setResponse(response + 'ì')}>ì</Button>
                    <Button onClick={() => setResponse(response + 'ò')}>ò</Button>
                    <Button onClick={() => setResponse(response + 'ù')}>ù</Button>
                </ButtonGroup>
                <br></br> <br></br>
                <ButtonGroup>
                    <Button onClick={() => nextQuestion()}>Submit</Button>
                    <Button onClick={() => endTest()}>End test</Button>
                </ButtonGroup>
                <br></br> <br></br>
                <FormHelperText >{`Question ${total + 1} out of ${testLength}`}</FormHelperText>
                <br></br> <br></br>
                <FormHelperText >{resultString}</FormHelperText>
            </FormControl>
        </div>

    )
}