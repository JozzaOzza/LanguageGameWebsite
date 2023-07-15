import NavBar from "../components/navbar"
import Session from "../components/session"

function Adverbs() {

    const topics = [[{ name: "standard", id: 1 }, { name: "place", id: 2 }, { name: "quantity", id: 3 }], "adverbs"]

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