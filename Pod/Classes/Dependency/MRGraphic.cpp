//
//  MRGraphic.cpp
//  Pods
//
//  Created by baidu on 16/4/15.
//
//

#include "MRGraphic.hpp"
#include <stdlib.h>
bool MagicRecord::MRNode::operator=(MagicRecord::MRNode *node)
{
    return strcmp(node->identifier(), this->identifier()) == 0;
}

const char* MagicRecord::MRNode::identifier()
{
    return this->identy;
}


MagicRecord::MRNode::~MRNode()
{
    if (this->identy != NULL) {
        free(this->identy);
    }

    this->identy == NULL;
}
MagicRecord::MRNode::MRNode(const char* identifier) {
    char* temp = (char*)malloc(sizeof(char)* strlen(identifier) + 1);
    strcpy(temp, identifier);
    this->identy = temp;
}

void MagicRecord::MRGraphic::insertNode(const char * identifier) {
    if (this->isNodeExist(identifier)) {
        return;
    }
    this->nodes.push_back(new MRNode(identifier));
}

bool MagicRecord::MRGraphic::isNodeExist(const char * identifier) {
    std::vector<MRNode>::iterator iterator ;
    for (iterator = nodes.begin(); iterator != nodes.end(); iterator++) {
        if (strcmp(identifier,iterator->identifier()) == 0) {
            return true;
        }
    }
    return false;
}


MagicRecord::MRNode* MagicRecord::MRGraphic::nodeWithIdentifer(const char *identifier) {
    std::vector<MRNode>::iterator iterator ;
    for (iterator == nodes.begin(); iterator != nodes.end(); iterator++) {
        if (strcmp(identifier, iterator->identifier()) == 0) {
            return iterator.base();
        }
    }
    return NULL;
}

void MagicRecord::MRGraphic::insertArc(const char *node1,const char* node2) {
    this->insertNode(node1);
    this->insertNode(node2);
    
    MRArc arc = MRArc();
    MRNode* n1 = this->nodeWithIdentifer(node1);
    MRNode* n2 = this->nodeWithIdentifer(node2);
    
    arc.headNode = n1;
    arc.tailNode = n2;
    
    arc.outLink = n1->firstOut->outLink;
    n1->firstOut = &arc;
    
    arc.inLink = n2->firstIn->inLink;
    n2->firstIn = &arc;
    arcs.push_back(arc);
}

bool MagicRecord::MRGraphic::circleCheck(MRNode node, std::map<const char*, bool>& visit, std::vector<MRNode>& father) {
    visit[node.identifier()] = true;
   
    MRArc* arc = node.firstOut;
    for (; arc->outLink != NULL ; arc == arc->outLink)
    {
        MRNode* currentNode = arc->tailNode;
        if (visit[currentNode->identifier()]) {
            return true;
        } else {
            father.push_back(*currentNode);
        }
    }
    return false;
}

MagicRecord::MRGraphic::MRGraphic() {
    
}