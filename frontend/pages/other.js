import NavBar from "../components/navbar"
import Session from "../components/session"

function Other() {

    const topics = [[
        { name: "pronouns", id: 1 }, 
        { name: "connectives", id: 2 }, 
        { name: "prepositions", id: 3 }, 
        { name: "question words", id: 4 }, 
        { name: "interjections", id: 5 }, 
        { name: "articles", id: 6 }], 
        5]

    return (
        <div className="other" >
            <NavBar></NavBar>
            <div>
                <Session topics={topics}></Session>
            </div>
        </div>
    )
}

export default Other