import NavBar from "../components/navbar"
import Session from "../components/session"

function Adverbs() {

    const topics = [[
        { name: "manner", id: 1 }, { name: "miscellaneous", id: 2 }, { name: "place", id: 3 },
        { name: "quantity", id: 4 }, { name: "standard", id: 5 }, { name: "time", id: 6 },
    ], "adverbs"]

    return (
        <div className="adverbs" >
            <NavBar></NavBar>
            <div>
                <Session topics={topics}></Session>
            </div>
        </div>
    )
}

export default Adverbs